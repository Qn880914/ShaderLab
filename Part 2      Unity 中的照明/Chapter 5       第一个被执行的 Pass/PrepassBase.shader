Shader "Custom/PrepassBase"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
	}

		SubShader
	{
		Tags{}

		Pass
		{
			Tags{"LightMode" = "PrepassBase"}

			CGPROGRAM
#pragma target 3.0
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
				float4 color : COLOR;
			};

			v2f vert(VertexInput i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.position);
				o.color = _LightColor0;
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return i.color;
			}

			ENDCG
		}
	}
}
