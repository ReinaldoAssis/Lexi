using System;
using System.Threading.Tasks;
using Blazored.LocalStorage;
using Microsoft.AspNetCore.Components.Server.ProtectedBrowserStorage;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using OpenManga.Pages;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
<<<<<<< HEAD
using ElectronNET.API;
using LiteDB;
using static Lexi.Pages.Mangas;
=======
using static OpenManga.Pages.Mangas;
>>>>>>> parent of 7ef89b2 (MAJOR FIX: Renamed project caused build failure)

namespace Database
{
    public interface IDatabase
    {
        Task<List<Mangas.DataManga>> GetMangas();
        void Write(string col, string key, object value);

        DataBase.DBItem Read(string col, string key);

        //void SetLocalStorage(ILocalStorageService storage);

        void SaveManga(DataManga manga);

        Task<DataManga> GetManga(string id);

        void DELETEWHOLEDB();

        string GenerateID();

    }
    // public class DataBase : IDatabase
    // {
    //     private ILocalStorageService localStorage;
    //
    //     public async void Write(string key, object value)
    //     {
    //         await localStorage.SetItemAsync(key, value);
    //     }
    //
    //     public async Task<T> Read<T>(string key)
    //     {
    //         return await localStorage.GetItemAsync<T>(key);
    //     }
    //
    //     public void SetLocalStorage(ILocalStorageService storage)
    //     {
    //         localStorage = storage;
    //     }
    //
    //     public async Task<List<Mangas.DataManga>> GetMangas()
    //     {
    //         return await localStorage.GetItemAsync<List<Mangas.DataManga>>("mangas") ?? new List<DataManga>();
    //     }
    //
    //     public async void SaveManga(DataManga manga)
    //     {
    //         List<DataManga> mangas = await GetMangas(); //get mangas list from db
    //         
    //         if (manga.id == null) manga.id = GenerateID(); //checks if current manga has an id
    //         else mangas.RemoveAll(x => x.id == manga.id); //remove all copies
    //         
    //         await localStorage.SetItemAsync("mangas", mangas.Append(manga)); //appends new copy
    //     }
    //
    //     public async void DELETEWHOLEDB()
    //     {
    //         await localStorage.ClearAsync();
    //     }
    //
    //     public async Task<DataManga> GetManga(string id)
    //     {
    //         List<DataManga> mangas = await GetMangas();
    //         return mangas.Find(x => x.id == id) ?? new DataManga();
    //     }
    //
    //     public string GenerateID()
    //     {
    //         Random random = new Random();
    //         string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    //         string id = "";
    //         for (int i = 0; i < 11; i++) id += chars[random.Next(chars.Length - 1)];
    //         return id;
    //     }
    // }

    public class DataBase : IDatabase
    {
        public class DBItem
        {
            public object Value { get; set; }
            public int Id { get; set; }
            public string Key { get; set; }

            public DBItem(object value, string key)
            {
                Value = value;
                Key = key;
            }
        }
        private string DbName = Config.DbName;
        private string AppPath;

        async void SetPathAsync()
        {
            AppPath = await Electron.App.GetAppPathAsync(); //get current app path
        }

        string PathToDb()
        {
            if (AppPath != null) return AppPath.Replace('\\', '/') + $"/{DbName}";
            throw new NullReferenceException("AppPath not set to get Path To Db.");
        }

        public void Write(string col, string key, object value)
        {
            using (var local = new LiteDatabase(PathToDb()))
            {
                var collection = local.GetCollection<DBItem>(col); //to clarify, i don't know if this is correct lol much less if it's the correct practice
                collection.Upsert(new DBItem(value, key)); //my idea was to use an abstract type, but I couldn't work out the logic for it so I gave up and used a class (DBItem) to contain the value
            }
        }

        public DBItem Read(string col, string key)
        {
            using (var local = new LiteDatabase(PathToDb()))
            {
                var collection = local.GetCollection<DBItem>(col); //to clarify, i don't know if this is correct lol much less if it's the correct practice
                try
                {
                    var aux = collection.FindOne(x => x.Key == key);
                    if (aux != null) return aux;
                    throw new WarningException($"Couldn't read value of key {key}. It's null.");
                }
                catch(Exception e)
                {
                    Console.WriteLine(e);
                }
            }

            return new DBItem(null, null);
        }

        //appends value to a var
        public List<DBItem> Append(string col, string key, string value)
        {
            
        }
        
        public async Task<List<Mangas.DataManga>> GetMangas()
        {
            throw new NotImplementedException();
        }
        
        public async void SaveManga(DataManga manga)
        {
            throw new NotImplementedException();
        }
        
        public async void DELETEWHOLEDB()
        {
            throw new NotImplementedException();
        }
        
        public async Task<DataManga> GetManga(string id)
        {
            throw new NotImplementedException();
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
    
}
