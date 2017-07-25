using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class ChangeShaderInspector : MaterialEditor
{
    bool isSquare = true;
    float isSquareF = 1.0f;
	// マテリアルへのアクセス
	Material material
	{
		get
		{
			return (Material)target;
		}
	}

	// Inspectorに表示される内容
	public override void OnInspectorGUI()
	{
		// マテリアルを閉じた時に非表示にする
		if (isVisible == false) { return; }

		// 入力内容が変更されたかチェック
		EditorGUI.BeginChangeCheck();

		// InspectorのGUIを定義
		//Texture mainTex = EditorGUILayout.ObjectField(
		//"main texture",
		//material.GetTexture("_MainTex"),
		//typeof(Texture),
		//false) as Texture;
		Color color1 = EditorGUILayout.ColorField(
			"Color1",
			material.GetColor("_Color1")); 
        Color color2 = EditorGUILayout.ColorField(
	        "Color2",
	        material.GetColor("_Color2"));

        isSquare = EditorGUILayout.Toggle("isSquare", isSquare);
        int boxes=0, boxesH=0, boxesW=0;
        if(isSquare){
            isSquareF = 1.0f;
            boxes = EditorGUILayout.IntField("Boxes",
                                                 material.GetInt("_Boxes"));
        } else {
			isSquareF = 0.0f;
			boxesH = EditorGUILayout.IntField("BoxH",
												 material.GetInt("_BoxesH"));
            boxesW = EditorGUILayout.IntField("BoxW",
                                              material.GetInt("_BoxesW"));
		}

		// 更新されたら内容を反映
		if (EditorGUI.EndChangeCheck())
		{
			//material.SetTexture("_MainTex", mainTex);
			material.SetColor("_Color1", color1);
			material.SetColor("_Color2", color2);
            material.SetFloat("_isSquare",isSquareF);
            if (isSquare)
            {
                material.SetInt("_Boxes", boxes);
            } else
            {
                material.SetInt("_BoxesH", boxesH);
                material.SetInt("_BoxesW", boxesW);
            }
		}
	}
}
