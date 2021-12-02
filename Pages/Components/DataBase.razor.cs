using System;
using System.Threading.Tasks;
using Blazored.LocalStorage;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Lexi.Pages;
using System.Collections.Generic;
using System.Linq;
using static Lexi.Pages.Mangas;

namespace Database
{
    public interface IDatabase
    {
        Task<List<Mangas.DataManga>> GetMangas();
        void Write(string key, object value);

        Task<T> Read<T>(string key);

        void SetLocalStorage(ILocalStorageService storage);

        void SaveManga(DataManga manga);

        Task<DataManga> GetManga(string id);

        void DELETEWHOLEDB();

        string GenerateID();

    }
    public class DataBase : IDatabase
    {
        private ILocalStorageService localStorage;

        public async void Write(string key, object value)
        {
            await localStorage.SetItemAsync(key, value);
        }

        public async Task<T> Read<T>(string key)
        {
            return await localStorage.GetItemAsync<T>(key);
        }

        public void SetLocalStorage(ILocalStorageService storage)
        {
            localStorage = storage;
        }

        public async Task<List<Mangas.DataManga>> GetMangas()
        {
            return await localStorage.GetItemAsync<List<Mangas.DataManga>>("mangas") ?? new List<DataManga>();
        }

        public async void SaveManga(DataManga manga)
        {
            List<DataManga> mangas = await GetMangas(); //get mangas list from db
            
            if (manga.id == null) manga.id = GenerateID(); //checks if current manga has an id
            else mangas.RemoveAll(x => x.id == manga.id); //remove all copies
            
            await localStorage.SetItemAsync("mangas", mangas.Append(manga)); //appends new copy
        }

        public async void DELETEWHOLEDB()
        {
            await localStorage.ClearAsync();
        }

        public async Task<DataManga> GetManga(string id)
        {
            List<DataManga> mangas = await GetMangas();
            return mangas.Find(x => x.id == id) ?? new DataManga();
        }

        public string GenerateID()
        {
            Random random = new Random();
            string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            string id = "";
            for (int i = 0; i < 11; i++) id += chars[random.Next(chars.Length - 1)];
            return id;
        }
    }

    // public class DataBase : IDatabase
    // {
    //     
    // }
    
}
