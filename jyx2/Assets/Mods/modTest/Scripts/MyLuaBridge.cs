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
            //Talk(0, "�Զ���luaAPI�Ĳ���", ()=> {
            //    Talk(0, "�Ի�", ()=> { Debug.Log("C#�ű�ִ�����"); callback?.Invoke(); });
            //});
            Talk(0, "�Զ���luaAPI�Ĳ���", callback);
            Debug.Log("�����Ƿ���Ҫ��������ӳ��,�Ķ��Ĵ���Ż���Ч");
        }
        public static void TestTalk2()
        {
            Debug.Log("�����Ƿ���Ҫ��������ӳ��,��ӵ�API�Ż���Ч");
            
        }
    }
}

