using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Jyx2
{
    public partial class Jyx2LuaBridge
    {
        public static void TestTalk(System.Action callback)
        {
            //AddItem(174, 222);
            //Talk(0, "自定义luaAPI的测试", ()=> {
            //    Talk(0, "对话", ()=> { Debug.Log("C#脚本执行完毕"); callback?.Invoke(); });
            //});
            Talk(0, "自定义luaAPI的测试", callback);
            Debug.Log("测试是否需要重新生成映射,改动的代码才会生效");
        }
        public static void TestTalk2()
        {
            Debug.Log("测试是否需要重新生成映射,添加的API才会生效");
            
        }
    }
}

