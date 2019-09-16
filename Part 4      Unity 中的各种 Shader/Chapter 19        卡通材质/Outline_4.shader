Shader "Unlit/Outline_4"
{
	Properties
	{
		_Outline("Out line", Range(0, 0.1)) = 0.05
		_Outline2("Out line2", Range(0, 0.1)) = 0.05
		_Factor("Factor", Range(0, 1.0)) = 0.5
		_Factor2("Factor2", Range(0, 1.0)) = 0.5
	}

		SubShader
	{
		Tags{"Queue" = "Geometry"}

		Pass
		{
			Cull Front

			ZWrite Off

			Tags{"LightMode" = "Always"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

			float _Factor;
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
				o.vertex = UnityObjectToClipPos(v.vertex);
				float3 dir = normalize(v.vertex.xyz);
				float3 dir2 = v.normal;
				dir = lerp(dir, dir2, _Factor);
				dir = mul((float3x3)UNITY_MATRIX_IT_MV, dir);
				float2 offset = TransformViewToProjection(dir.xy);
				offset = normalize(offset);
				o.vertex.xy += offset * o.vertex.z * _Outline;
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
			Cull Back

			ZWrite On

			Tags{"LightMode" = "Always"}
			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

			float _Factor2;
			float _Outline2;

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
				o.vertex = UnityObjectToClipPos(v.vertex);
				float3 dir = normalize(v.vertex.xyz);
				float3 dir2 = v.normal;
				dir = lerp(dir, dir2, _Factor2);
				dir = mul((float3x3)UNITY_MATRIX_IT_MV, dir);
				float2 offset = TransformViewToProjection(dir.xy);
				offset = normalize(offset);
				o.vertex.xy += offset * o.vertex.z * _Outline2;
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
				//Blend DstColor Zero

				Tags{"LightMode" = "ForwardBase"}
				CGPROGRAM
	#pragma vertex vert
	#pragma fragment frag
	#include "UnityCG.cginc"
	#include "Lighting.cginc"


					float _Factor2;
			float _Outline2;
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

				float3 dir = normalize(v.vertex.xyz);
				float3 dir2 = v.normal;
				dir = lerp(dir, dir2, _Factor2);
				dir = mul((float3x3)UNITY_MATRIX_IT_MV, dir);
				float2 offset = TransformViewToProjection(dir.xy);
				offset = normalize(offset);
				o.vertex.xy += offset * o.vertex.z * _Outline2;
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float4 c = 0;
				float diff = dot(i.normal, i.lightDir);
				diff = (diff + 1) / 2;
				diff = smoothstep(diff / 12, 1, diff);
				c = _LightColor0 * diff;
				return float4(1.0, 0.0, 0.0, 1.0);
			}
			ENDCG
		}
	}
}
