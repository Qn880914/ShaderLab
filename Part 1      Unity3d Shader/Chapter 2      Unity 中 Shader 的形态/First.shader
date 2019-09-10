Shader "Custom/First"
{
	Properties
	{
		// Texture
		_MainTex("Main Tex(RGB)", 2D) = "white"{}
		_CubeTex("Cube Tex", Cube) = "white"{}
		_2DArrayTex("2DArray Tex", 2DArray) = "white"{}
		_3DTex("3D Tex", 3D) = "white"{}

		// Number and slider
		_Float("Float", float) = 1
		_Int("Int", int) = 1
		_Range("Range", Range(0,1)) = 0.5

		// Color and Vector
		_Color("Color", Color) = (1,0,0,1)
		_Vector("Vector", Vector) = (1,0,0)

		[HideInInspector]_HideTex("Hide Tex", 2D) = "white"{}
		[NoScaleOffset]_NoScaleOffsetTex("NoScaleOffset Tex", 2D) = "white"{}
		[Normal]_Normal("Normal", 2D) = "white"{}
		[HDR]_HDR("HDR", 2D) = "white"{}
		[Gama]_Gama("Gama", 2D) = "white"{}
		[PreRendererData]_PreRendererData("PreRendererData", 2D) = "white"{}


		[Toggle(USE_LIGHTMAP)] _UseLightMap("Use LigthMap", float) = 0
		[Space(5)]
		[Header(More Settings)]

		[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("Src Blend Mode", float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("Dst Blend Mode", float) = 1
		[Enum(Off, 0, On, 1)] _ZWrite("ZWrite", float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]_ZTest("ZTest", float) = 4
		[Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull Mode", float) = 2
	}

	// 针对不同的显卡
	SubShader									
	{
		// Queue :
		//		decides which render queue its objects belong to, this way any Transparent shaders make sure they are drawn after all opaque objects and so on.
		//			Background	1000			: this render queue is rendered before any others. You'd typically use this for things that really need to be in the background.
		//			Geometry	2000(default)	: this is used for most objects. Opaque geometry uses this queue.
		//			AlphaTest	2045			: alpha tested geometry uses this queue. It's a separate queue from geometry one since it's more efficient to render alpha-tested objects after all solid ones are drawn.
		//			Transparent	3000			: this render queue is rendered after Geometry and AlphaTest,  in back-to-front order. Anything alpha-blended (i.e. shaders that don't write to depth buffer) should go here (glass, particle effects).
		//			Overlay		4000			: this render queue is meant for overlay effects. Anything rendered last should go here (e.g. lens flares)
		// RenderType :	Use for ReplacementShader
		//		This is used by Shader Replacement and in some cases used to produce camera's depth texture.
		//			Camera.RenderWithShader / Camera.SetReplacementShader
		//		Note : Camera.RenderWithShader must in OnGUI
		//			Opaque
		//			Transparent
		//			TrabsparentCut
		//			Background
		//			Overlay
		// DisableBatching
		//		Some Shader (mostly ones that do object-space vertex deformations) do not work when Draw Call Batching is used - that's because batching transforms all geometry into world space, so "object space" is lost.
		//			True	: always disables batching for this shader
		//			False	: does not disable batching; this is default
		//			lodfade : disable batching when LOD fading is active; mostly used on trees
		// ForceNoShadowCasting
		//		If ForceNoShadowCasting tag is given and has a value of “True”, then an object that is rendered using this subshader will never cast shadows. This is mostly useful when you are using shader replacement on transparent objects and you do not wont to inherit a shadow pass from another subshader.
		//			True
		//			False
		// IgnoreProjector
		//		If IgnoreProjector tag is given and has a value of “True”, then an object that uses this shader will not be affected by Projectors. This is mostly useful on semitransparent objects, because there is no good way for Projectors to affect them.
		//			True
		//			False
		// CanUseSpriteAtlas
		//		Set CanUseSpriteAtlas tag to “False” if the shader is meant for sprites, and will not work when they are packed into atlases (see Sprite Packer).
		//			True
		//			False
		// PreviewType
		//			Plane
		//			Skybox
		Tags
		{
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
			"DisableBatching" = "True"
			"ForceNoShadowCasting" = "False"
			"IgnoreProjector" = "False"
			"CanUseSpriteAtlas" = "True"
			"PreviewType" = "Plane"
		}

		//  The Pass block causes the geometry of a GameObject to be rendered once.
		Pass
		{
			//		Name : Gives the PassName name to the current pass. Note that internally the names are turned to uppercase.
			//				UsePass Name
			Name "MyPass"

			// Passes use tags to tell how and when they expect to be rendered to rendering engine.
			// tags 都是针对渲染路径的
			//			
			Tags
			{
			}

			//ZTest Greater
			ZTest LEqual


			// CG/HLSL  : CGPROGRAM ... ENCG
			// GLSL		: GLSLPROGRAM ... ENDGLSL
			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			float4 _Color;

			struct vertexInput
			{
				float4 position : POSITION;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
			};

			v2f vert(vertexInput i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.position);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return _Color;//float4(1.0, 0.0, 0.0, 1.0);
			}
			ENDCG
		}
	}

	// FallBack 保证Shader的广泛适应性, 如果所有的SubShader 都失败了，一般会使用FallBack
	FallBack "Diffuse"
}