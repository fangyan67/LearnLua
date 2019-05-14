using LuaFramework;
using LuaInterface;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LearnMain : MonoBehaviour
{
    private LuaState lua;
    public static LearnMain Instance;
    public LearnButtonBuilder lbb;

    void Start ()
    {
        Instance = this;
        lua = new LuaState();
        lua.Start();

        lua.DoFile("Learn/LearnMain.lua");

        LuaFunction funcMain = lua.GetFunction("LearnMain");
        if(funcMain != null) {
            funcMain.BeginPCall();
            funcMain.PCall();
            int n = (int)funcMain.CheckNumber();
            funcMain.EndPCall();
            Debug.Log("Chapter Count: " + n);
            lbb.Init(n);
        }
    }

    public void LogChapter(int n)
    {
        lua.DoFile("Learn/LearnChapter" + n);
    }

    void OnDestroy()
    {
        lua.Dispose();
        lua = null;
    }
}
