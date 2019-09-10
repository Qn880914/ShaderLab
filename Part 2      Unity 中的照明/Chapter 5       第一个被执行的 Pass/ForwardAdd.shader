Shader "Custom/ForwardAdd"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white"{}

		[HideInInspector]_HideInInspector("Hide In Inspector", 2D) = "white"{}
		[NoScaleOffset]_NoScaleOffset("No Scale Offset", 2D) = "white"{}
		[Gama]_Gama("Gama", 2D) = "white"{}
		[Normal]_Normal("Normal", 2D) = "white"{}
		[HDR]_HDR("HDR", 2D) = "white"{}
		[PreRenderData]_PreRenderData("PreRender Data", 2D) = "white"{}
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
			"ForceNoShadowCasting" = "False"
			"IgnoreProjector" = "False"
			"CanUseSpriteAtlas" = "lodfade"
			"DisableBatching" = "False"
			"PreviewType" = "Cube"
		}

		Pass
		{
			Blend One One
			Tags{"LightMode" = "ForwardBase"}

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

			float4 frag(v2f i):COLOR
			{
				return float4(0.5, 0.0, 0.0, 1.0);
			}

				ENDCG
	}

		Pass
		{
			Blend One Zero
			Tags {"LightMode" = "ForwardAdd"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			float4 _LightColor0;

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
				return _LightColor0;// float4(0.0, 0.0, 0.5, 1.0);
			}
			ENDCG
		}
	}
}
