Shader "Hidden/Filter4kb"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Resolution("Resolution Constant", Float) = 1
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			float _Resolution;

			fixed4 frag (v2f i) : SV_Target
			{
				float2 resolution = _ScreenParams.xy / _Resolution;
				i.uv = floor(i.uv * resolution) / resolution;
				float3 col = tex2D(_MainTex, i.uv).rgb;
				
				float3 ret = float3(col.r > 0.333, col.g > 0.333, col.b > 0.333);
				if ((col.r + col.g + col.b) / 3. < 0.5) return float4(ret / 2., 0.);
				return float4(ret, 0.);
			}
			ENDCG
		}
	}
}
