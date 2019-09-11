Shader "Custom/RenderQueue"
{
	Properties
	{
		_MainTex("MainTex(RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Tags{"Queue" = "Geometry"}

		Pass
		{
			//ZTest Always

			Tags{"LightMode" = "Vertex"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag
			
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
			};

			v2f vert(VertexInput i)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(i.vertex);
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
