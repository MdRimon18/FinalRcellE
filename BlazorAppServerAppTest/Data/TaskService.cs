using Microsoft.EntityFrameworkCore;

namespace Pms.Data
{
     
    using Microsoft.EntityFrameworkCore;
    using Microsoft.Extensions.Options;
    // TaskService.cs
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using BlazorAppServerAppTest.Models;

    public class TaskService
    {
        private List<TaskModel> tasks;
        private readonly practiceDbContext _db;
        public TaskService(practiceDbContext practiceDbContext)
        {
            tasks = new List<TaskModel>();
            _db = practiceDbContext;
        }
        public   List<TaskModel> GetTasks()
        {
          // var campainResult=  _db.Bonus.ToList();
            return   tasks;
        }

        public async  Task<List<Bonus>> getBonus()
        {
            try
            {
                return await _db.Bonus.ToListAsync();
            }
            catch (Exception e)
            {

                return new List<Bonus>();
            }
            
        }


        public void AddTask(TaskModel task)
        {
            task.Id = tasks.Any() ? tasks.Max(t => t.Id) + 1 : 1;
            tasks.Add(task);
        }

        public void UpdateTask(TaskModel task)
        {
            var existingTask = tasks.FirstOrDefault(t => t.Id == task.Id);
            if (existingTask != null)
            {
                existingTask.Title = task.Title;
                existingTask.IsCompleted = task.IsCompleted;
            }
        }

        public void DeleteTask(int taskId)
        {
            var task = tasks.FirstOrDefault(t => t.Id == taskId);
            if (task != null)
            {
                tasks.Remove(task);
            }
        }
    }

}





//public void AddTask(Task task)
//{
//    _dbContext.Tasks.Add(task);
//    _dbContext.SaveChanges();
//}

//public void UpdateTask(Task task)
//{
//    _dbContext.Tasks.Update(task);
//    _dbContext.SaveChanges();
//}

//public void DeleteTask(int taskId)
//{
//    var task = _dbContext.Tasks.Find(taskId);
//    if (task != null)
//    {
//        _dbContext.Tasks.Remove(task);
//        _dbContext.SaveChanges();
//    }
//}
