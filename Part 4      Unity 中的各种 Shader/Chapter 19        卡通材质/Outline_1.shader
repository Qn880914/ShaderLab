Shader "Unlit/Outline_1"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
		_Outline("Outline", float) = 1
	}

	SubShader
	{
		Tags{"Queue" = "Transparent" "RenderType" = "Opaque"}

		Pass
		{
			Tags{"LightMode" = "Always"}

			Cull Off
			ZWrite Off

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			float _Outline;

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				v.vertex.xyz += v.normal * _Outline;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return 0;
			}
			ENDCG
		}

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			Blend One One

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#include "Lighting.cginc"

			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 lightDir : TEXCOORD0;
				float3 viewDir : TEXCOORD1;
				float3 normal : TEXCOORD2;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = normalize(v.normal);
				o.viewDir = normalize(ObjSpaceViewDir(v.vertex));
				o.lightDir = normalize(ObjSpaceLightDir(v.vertex));
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 c = 0;
				float diff = dot(i.normal, i.lightDir);
				diff = (diff + 1) / 2;
				diff = smoothstep(diff / 12, 1, diff);
				c = _LightColor0 * diff;
				return c;
			}
			ENDCG
		}
	}
}
