// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/Tangent_Space"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
		_3D("3D", 3D) = "white" {}
		_2DArray("2D Array", 2DArray) = "white" {}
		_Cube("Cube", Cube) = "white" {}

		_Float("Float", float) = 1
		_Int("Int", int) = 1
		_Range("Range", Range(0, 1)) = 0.5
		
		_Vector("Vector", Vector) = (1.0, 0.0, 0.0, 1.0)
		_Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)

		[Normal]_BumpTex("Bump Tex", 2D) = "white" {}

		[HideInInspector]_HideInInspector("Hide In Inspector", 2D) = "white"{}
		[NoScaleOffset]_NoScaleOffset("No Scale Offset", 2D) = "white" {}
		[Gama]_Game("Gama", 2D) = "white" {}
		[HDR]_HDR("HDR", 2D) = "white" {}
		[PreRenderData]_PreRenderData("PreRender Data", 2D) = "white" {}
	}

		SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
			"ForceNoShadowCasting" = "False"
			"IgnoreProjector" = "False"
			"CanUseSpriteAtlas" = "True"
			"DisableBatching" = "False"
			//"PreViewType" = "Plane"
		}

		Pass
		{
			Tags
			{
				"LightMode" = "ForwardBase"
			}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"
#include "Lighting.cginc"

			sampler2D _BumpTex;

			struct VertexInput
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;
				float3 lightDir : TEXCOORD1;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color = v.color;
				o.uv = v.uv;
				TANGENT_SPACE_ROTATION;
				o.lightDir = mul(unity_WorldToObject, _WorldSpaceLightPos0).xyz;
				o.lightDir = mul(rotation, o.lightDir);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float3 N = UnpackNormal(tex2D(_BumpTex, i.uv));
				float diff = max(0, dot(N, i.lightDir));
				float4 c = _LightColor0 * diff;
				return c;
			}
			ENDCG
		}
	}
}
