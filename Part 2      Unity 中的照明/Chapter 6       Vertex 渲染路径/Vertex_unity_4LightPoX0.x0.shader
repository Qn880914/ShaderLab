Shader "Custom/Vertex_unity_4LightPoX0.x0"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#include "Lighting.cginc"

			struct VertexInput
			{
				float4 position : POSITION;
				float4 color : COLOR;
				float3 normal : NORMAL;
				float3 tangent : TANGENT;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float4 color : COLOR;
			};

			v2f vert(VertexInput i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.position);
				o.color = unity_4LightPosX0[0];
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return i.color;//unity_LightColor[4];//i.color;
			}
			ENDCG
		}
	}
}
