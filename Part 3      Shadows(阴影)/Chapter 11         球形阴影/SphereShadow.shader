Shader "Custom/Shadow/SphereShadow"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
		_3D("3D Tex", 3D) = "white" {}
		_Cube("Cube Tex", Cube) = "white" {}
		_2DArray("2D Array", 2DArray) = "white" {}

		_Float("Float", float) = 1
		_Int("Int", int) = 1
		_Range("Range", Range(0, 1)) = 0.5

		_Color("Color", Color) = (1.0, 0.0, 0.0, 1.0)
		_Vector("Vector", Vector) = (1.0, 1.0, 1.0, 1.0)

		[HideInInspector]_HideInInspector("Hide In Inspector", 2D) = "white" {}
		[NoScaleOffset]_NoScaleOffset("No Scale Offset", 2D) = "white" {}
		[Gama]_Gama("Gama", 2D) = "white" {}
		[HDR]_HDR("HDR", 2D) = "white" {}
		[Normal]_Normal("Normal", 2D) = "white" {}
		[PreRenderData]_PreRenderData("PreRenderData", 2D) = "white" {}

		_spPosition("Sphere Position", Vector) = (1.0, 1.0, 1.0, 1.0)
		_spRadius("Sphere Radius", float) = 1.0
		_Intensity("Intensity", float) = 1.0
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
				"PrevieType" = "Cube"
			}

			Pass
			{
				Tags{"LightMode" = "Vertex"}

				CGPROGRAM
	#include "UnityCG.cginc"
	#pragma vertex vert
	#pragma fragment frag

				float4 _spPosition;
				float _spRadius;
				float _Intensity;

			struct VertexInput
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float3 normal : NORMAL;
				float3 tangent : TANGENT;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 lightDir : TEXCOORD0;
				float3 sphereDir : TEXCOORD1;
				float4 vertexColor : TEXCOORD2;
			};

			v2f vert(VertexInput i)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(i.vertex);
				o.lightDir = WorldSpaceLightDir(i.vertex);
				float4 worldPosition = mul(unity_ObjectToWorld, i.vertex);
				o.sphereDir = (_spPosition - worldPosition).xyz;
				float3 lDir = normalize(ObjSpaceLightDir(i.vertex));
				o.vertexColor = unity_LightColor[0] * max(0, dot(lDir, i.normal));
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float3 lightDir = normalize(i.lightDir);
				float3 spDir = i.sphereDir;
				float spDistance = length(spDir);
				spDir = normalize(spDir);
				float cosV = dot(spDir, lightDir);
				float sinV = sin(acos(max(0, cosV)));
				float d = sinV * spDistance;
				float shadow = step(_spRadius, d);
				float c = lerp(1-_Intensity, 1, shadow);
				return i.vertexColor * c;
			}
			ENDCG
		}
	}
}
