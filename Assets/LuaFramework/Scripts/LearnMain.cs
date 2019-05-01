using LuaFramework;
using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LearnMain : MonoBehaviour
{
    private LuaState lua;

    void Start ()
    {
        lua = new LuaState();
        lua.Start();

        lua.DoFile("Learn/LearnMain.lua");

        LuaFunction main = lua.GetFunction("LearnMain");
        main.Call();
        main.Dispose();
        main = null;
        //this.OpenLibs();
        //lua.LuaSetTop(0);

        //LuaBinder.Bind(lua);
        //DelegateFactory.Init();
        //LuaCoroutine.Register(lua, this);

        //LuaManager.InitStart();
        //LuaManager.DoFile("Logic/Game");         //加载游戏
        //LuaManager.DoFile("Logic/Network");      //加载网络
        //Util.CallMethod("Game", "OnInitOK");     //初始化完成
    }

    public void LogChapter(int n)
    {
        lua.DoFile("Learn/LearnChapter" + n);
        
    }

    //private AppFacade m_Facade;
    //private LuaManager m_LuaMgr;

    //protected AppFacade facade {
    //    get {
    //        if(m_Facade == null) {
    //            m_Facade = AppFacade.Instance;
    //        }
    //        return m_Facade;
    //    }
    //}

    //protected LuaManager LuaManager {
    //    get {
    //        if(m_LuaMgr == null) {
    //            m_LuaMgr = facade.GetManager<LuaManager>(ManagerName.Lua);
    //        }
    //        return m_LuaMgr;
    //    }
    //}

    //void OpenLibs()
    //{
    //    lua.OpenLibs(LuaDLL.luaopen_pb);
    //    lua.OpenLibs(LuaDLL.luaopen_sproto_core);
    //    lua.OpenLibs(LuaDLL.luaopen_protobuf_c);
    //    lua.OpenLibs(LuaDLL.luaopen_lpeg);
    //    lua.OpenLibs(LuaDLL.luaopen_bit);
    //    lua.OpenLibs(LuaDLL.luaopen_socket_core);
    //}

    //protected void OpenCJson()
    //{
    //    lua.LuaGetField(LuaIndexes.LUA_REGISTRYINDEX, "_LOADED");
    //    lua.OpenLibs(LuaDLL.luaopen_cjson);
    //    lua.LuaSetField(-2, "cjson");

    //    lua.OpenLibs(LuaDLL.luaopen_cjson_safe);
    //    lua.LuaSetField(-2, "cjson.safe");

    //    this.OpenCJson();
    //}
}
