using Dapper;

using Pms.Helper;
using System.Data;
using Pms.Models.Entity.Settings;
using System.Linq.Expressions;
using Pms.Domain.DbContex;

namespace Pms.Data.Repository.Shared
{

    public class ColumnPermissionService<T> where T : class
    {
        private readonly IDbConnection _db;
        public List<ColumnPermission<T>> TableClmns { get; set; } = new List<ColumnPermission<T>>();

        public ColumnPermissionService(DbConnection db)
        {
            _db = db.GetDbConnection();
        }

        public async Task<IEnumerable<ColumnPermission<T>>> TableColumnsPermissionGet(Guid? OrganizationId, int? TableId)
        {
            try
            {
                var parameters = new DynamicParameters();
                parameters.Add("@CompanyId", OrganizationId);
                parameters.Add("@BranchId", OrganizationId);
                parameters.Add("@TableId", TableId);

                var columns = await _db.QueryAsync<ColumnPermission<T>>("TableColumnsPermissionGet", parameters, commandType: CommandType.StoredProcedure);
                TableClmns = columns.ToList();
                return TableClmns;
            }
            catch (Exception ex)
            {
                // Log the exception
                return Enumerable.Empty<ColumnPermission<T>>();
            }
        }

        public async Task LoadColumnMappingsAsync(Guid? organizationId, int tableId)
        {
            await TableColumnsPermissionGet(organizationId, tableId);
            foreach (var column in TableClmns)
            {
                column.ValueAccessor = CreatePropertyAccessor(column.ColumnProprtyName);
            }
        }

        private Func<T, object> CreatePropertyAccessor(string propertyName)
        {
            var param = Expression.Parameter(typeof(T), "item");
            var property = Expression.Property(param, propertyName);
            var converted = Expression.Convert(property, typeof(object));
            return Expression.Lambda<Func<T, object>>(converted, param).Compile();
        }

        public IEnumerable<ColumnPermission<T>> GetVisibleColumns()
        {
            return TableClmns.Where(c => c.IsShow);
        }
    }

}
