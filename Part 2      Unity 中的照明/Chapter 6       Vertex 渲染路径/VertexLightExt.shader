Shader "Unlit/VertexLightExt"
{
	Properties
	{
		_Color("Color", Color) = (1.0, 0.0, 0.0, 1.0)
	}

		SubShader
	{
		Pass
		{
			Tags{"LightMode" = "Vertex"}

			CGPROGRAM
#pragma vertex vert
#pragma fragment frag

			float4 _Color;

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

			float3 ShaderVertexLight(float4 position, float3 normal)
			{
				float3 viewPos = mul(UNITY_MATRIX_MV, position).xyz;
				float3 viewNormal = mul(UNITY_MATRIX_IT_MV, normal);
				float3 lightColor = UNITY_LIGHTMODEL_AMBIENT.xyz;

				for(int i = 0; i < 4; ++ i)
				{
					float3 toLight = unity_LightPosition[i].xyz - viewPos * unity_LightPosition[i].w;
					float lengthSq = dot(toLight, toLight);
					float atten = 1.0 / (1.0 + lengthSq * unity_LightAtten[i].z);
					float diff = max(0, dot(viewNormal, normalize(toLight)));
					lightColor += unity_LightColor[i] * (atten * diff);
				}

				return lightColor;
			}

			v2f vert(VertexInput i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.position);
				o.color = float4(ShaderVertexLight(i.position, i.normal), 1.0);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return i.color * _Color;
			}
			ENDCG
		}
	}
}
