Shader "Unlit/Bump_Spec"
{
	Properties
	{
		[Normal] _BumpTex("Bump Tex", 2D) = "white" {} 
	}

	SubShader
	{
		Tags{ "Queue" = "Geometry" "RenderType" = "Opaque" }

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
#include "UnityCG.cginc"
#include "Lighting.cginc"

#pragma vertex vert
#pragma fragment frag

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
				float2 uv : TEXCOORD0;
				float3 lightDir : TEXCOORD1;
				float3 viewDir : TEXCOORD2;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;

				TANGENT_SPACE_ROTATION;
				o.lightDir = ObjSpaceLightDir(v.vertex);
				o.lightDir = mul(rotation, o.lightDir);
				o.viewDir = ObjSpaceViewDir(v.vertex);
				o.viewDir = mul(rotation, o.viewDir);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float3 N = UnpackNormal(tex2D(_BumpTex, i.uv));
				float diff = max(0, dot(N, i.lightDir));
				float3 h = normalize(i.lightDir + i.viewDir);
				float nh = max(0, dot(N, h));
				float spec = pow(nh, 32.0);
				float4 c = _LightColor0 * (diff + spec);
				return c;
			}
			ENDCG
		}
	}
}
