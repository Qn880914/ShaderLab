Shader "Custom/ForwardAdd"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Pass
		{
			Tags{"LightMode" = "ForwardAdd"}

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
				float4 color : COLOR;
			};

			v2f vert(VertexInput i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.position);
				o.color = float4(1.0, 0.0, 0.5, 1.0);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return unity_LightColor[0];//i.color;
			}
			ENDCG
		}
	}
}
