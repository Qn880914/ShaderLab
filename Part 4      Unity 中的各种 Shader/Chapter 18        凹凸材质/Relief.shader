Shader "Unlit/Relief"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
		_BumpTex("Bump Tex", 2D) = "white" {}
		_HeightTex("Hight Tex(A)", 2D) = "white" {}
		_Height("Height", Range(0, 1)) = 0.5
	}

		SubShader
		{
			Tags{"Queue" = "Geometry" "RenderType" = "Opaque"}

			Pass
			{
				Tags{"LightMode" = "ForwardBase"}

				CGPROGRAM
	#include "UnityCG.cginc"
	#include "Lighting.cginc"

	#pragma vertex vert
	#pragma fragment frag

				sampler2D _MainTex;
				sampler2D _BumpTex;
				sampler2D _HeightTex;
				float _Height;
				float4 _MainTex_ST;

				struct VertexInput
				{
					float4 vertex : POSITION;
					float4 color : COLOR;
					float4 tangent : TANGENT;
					float3 normal : NORMAL;
					float2 texcoord : TEXCOORD0;
				};

				struct v2f
				{
					float4 vertex : SV_POSITION;
					float2 uv : TEXCOORD0;
					float3 lightDir : TEXCOORD1;
					float3 viewDir : TEXCOORD2;
					float4 posW : TEXCOORD3;
				};

				v2f vert(VertexInput v)
				{
					v2f o;
					o.vertex = UnityObjectToClipPos(v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

					TANGENT_SPACE_ROTATION;
					o.lightDir = normalize(ObjSpaceLightDir(v.vertex));
					o.lightDir = mul(rotation, o.lightDir);
					o.viewDir = normalize(ObjSpaceViewDir(v.vertex));
					o.viewDir = mul(rotation, o.viewDir);
					o.posW = mul(unity_WorldToObject, v.vertex);
					return o;
				}

				float4 frag(v2f i) : COLOR
				{
					float viewRay = normalize(i.viewDir*-1);
					
					return 0;
				}
			ENDCG
		}
	}
}
