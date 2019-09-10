Shader "Unlit/VertexLight"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Pass
		{
			Tags{"LightMode" = "Vertex"}

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

			float3 ShaderVertexLights(float4 position, float3 normal)
			{
				float3 viewPos = mul(UNITY_MATRIX_MV, position).xyz;
				float3 viewNormal = mul((float3x3)UNITY_MATRIX_IT_MV, normal);
				float3 lightColor = UNITY_LIGHTMODEL_AMBIENT.xyz;
				for(int i = 0; i < 4; ++ i)
				{
					float3 toLight = unity_LightPosition[i].xyz - viewPos.xyz * unity_LightPosition[i].w;
					float lengthSq = dot(toLight, toLight);
					float atten = 1.0 / (1.0 + lengthSq * unity_LightAtten[i].z);
					float diff = max(0, dot(viewNormal, normalize(toLight)));
					lightColor += unity_LightColor[i].rgb * (diff * atten);
				}

				return lightColor;
			}

			v2f vert(VertexInput i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.position);
				o.color = float4(ShaderVertexLights(i.position, i.normal), 1.0);
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
