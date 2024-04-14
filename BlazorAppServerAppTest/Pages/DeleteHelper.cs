using Microsoft.AspNetCore.Components;
using Microsoft.JSInterop;

namespace Pms.Pages
{
    public class Unit : ComponentBase
    {
        [JSInvokable]
        public async Task DeleteConfirmed(long id)
        {
            // Your delete logic goes here
        }
    }
}
