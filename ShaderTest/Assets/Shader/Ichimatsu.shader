Shader "Unlit/Ichimatsu"
{
	Properties
	{
		//_MainTex ("Texture", 2D) = "white" {}
        _Color1 ("Color1", Color) = (1,1,1,1)
        _Color2 ("Color2", Color) = (0,0,0,0)
        _Boxes ("Boxes", int) = 2
        _BoxesH ("BoxH", int) = 2
        _BoxesW ("BoxW", int) = 2
        [MaterialToggle] _isSquare ("isSquare", Float) = 0 
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			//sampler2D _MainTex;
			//float4 _MainTex_ST;
            fixed4 _Color1;
            fixed4 _Color2;
            int _Boxes;
            int _BoxesH;
            int _BoxesW;
            Float _isSquare;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
                if(_isSquare == 1.0) {
                    o.uv = v.uv * _Boxes;
                } else {
	                o.uv.x = v.uv.x * _BoxesW;
	                o.uv.y = v.uv.y * _BoxesH;
                }
                
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
                float2 c = i.uv;    // uv座標
                c = floor(c) / 2;   // 2でわる（1.1->0.55）（0.7->0.35)
                float checker = frac(c.x + c.y) * 2;
                // 足して小数点以下入れる
                // 0.35+0.35=0.7
                if(checker==1) return _Color1;
                return _Color2;
		
			}
			ENDCG
		}
	}
    CustomEditor "ChangeShaderInspector"
}
