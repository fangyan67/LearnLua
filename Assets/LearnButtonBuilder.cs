using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class LearnButtonBuilder : MonoBehaviour
{
    public GameObject Prefab;

    public void Init(int chapterCount)
    {
        for(int i = 2; i <= chapterCount; i++) {
            int n = i;
            GameObject obj = Instantiate(Prefab, transform);
            string s = "Log Chapter" + n;
            obj.name = s;
            obj.GetComponentInChildren<Text>().text = s;
            UnityEngine.UI.Button.ButtonClickedEvent cce = new UnityEngine.UI.Button.ButtonClickedEvent();
            cce.AddListener(() =>
            {
                LearnMain.Instance.LogChapter(n);
            });
            obj.GetComponent<Button>().onClick = cce;
        }
    }
}