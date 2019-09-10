Shader "Custom/VertexLit"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white"{}
		_Cube("Cube", Cube) = "white"{}
		_2DArray("2D Array", 2DArray) = "white"{}
		_3D("3D", 3D) = "white"{}

		_Float("Float", float) = 1
		_Int("Int", int) = 1
		_Range("Range", Range(0, 1)) = 0.5

		_Color("Color", Color) = (1.0, 0.0, 0.0, 1.0)
		_Vector("Vector", Vector) = (1.0, 0.0, 0.0, 1.0)

		[HideInInspector]_HideInspector("Hide In Inspector", 2D) = "white"{}
		[NoScaleOffset]_NoScaleOffset("No Scale Offset", 2D) = "white" {}
		[Normal]_Normal("Normal", 2D) = "white" {}
		[Gama]_Game("Gama", 2D) = "white" {}
		[HDR]_HDR("HDR", 2D) = "white" {}
		[PreRenderData]_PreRenderData("PreRender Data", float) = 1
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
			"ForceNoShadowCasting" = "False"
			"IgnoreProjector" = "True"
			"CanUseSpriteAtlas" = "True"
			"DisableBatching" = "False"
			"PreviewType" = "Cube"
		}


		Pass
		{
			Tags
			{
				"LightMode" = "Vertex"
			}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

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
			};

			v2f vert(VertexInput i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.position);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return float4(1.0, 0.0, 0.0, 1.0);
			}
			ENDCG
		}
	}
}
