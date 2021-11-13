using System.Threading.Tasks;
using Blazored.LocalStorage;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

public partial class DataBase
{
    private ILocalStorageService localStorage;

    public DataBase(ILocalStorageService service)
    {
        localStorage = service;
    }
    
    public async Task<T> Read<T>(string key)
    {
        return await localStorage.GetItemAsync<T>(key);
    }
    
    public async Task Write<T>(string key, T value)
    {
        await localStorage.SetItemAsync<T>(key,value);
    }

    // public async Task WriteASJson<T>(string key, T value)
    // {
    //     await localStorage.SetItemAsync<string>(key, JsonConvert.SerializeObject<T>(value));
    // }
    //
    // public async Task ReadASJson(string key)
    // {
    //     return JsonConvert.DeserializeObject(await localStorage.GetItemAsync<string>(key));
    // }
}