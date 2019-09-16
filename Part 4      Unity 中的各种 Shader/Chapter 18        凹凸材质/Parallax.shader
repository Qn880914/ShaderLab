Shader "Unlit/Parallax"
{
	Properties
	{
		_MainTex("Main Tex", 2D) = "white" {}
		_BumpTex("Bump Tex", 2D) = "white" {}
		_ParallaxTex("Parallax Tex", 2D) = "white" {}
		_Parallax("Parallax", float) = 1
	}

		SubShader
	{
		Tags{"Queue" = "Geometry" "RenderType" = "Opaque"}

		Pass
		{
			Tags{"LightMode" = "ForwardBase"}

			CGPROGRAM
#include "UnityCG.cginc"
#include "Lighting.cginc"
#pragma vertex vert
#pragma fragment frag

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _BumpTex;
			sampler2D _ParallaxTex;
			float _Parallax;

			struct VertexInput
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				float4 tangent : TANGENT;
				float3 normal : NORMAL;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXOORD0;
				float3 lightDir : TEXCOORD1;
				float3 viewDir : TEXCOORD2;
				float4 posW : TEXCOORD3;
			};

			v2f vert(VertexInput v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
				TANGENT_SPACE_ROTATION;
				o.lightDir = normalize(ObjSpaceLightDir(v.vertex));
				o.lightDir = mul(rotation, o.lightDir);
				o.viewDir = normalize(ObjSpaceViewDir(v.vertex));
				o.viewDir = mul(rotation, o.viewDir);
				o.posW = mul(unity_ObjectToWorld, v.vertex);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				float p = tex2D(_ParallaxTex, i.uv).a;
				float2 offset = ParallaxOffset(p, _Parallax, i.viewDir);
				i.uv += offset;
				float4 c = tex2D(_MainTex, i.uv);
				float3 N = UnpackNormal(tex2D(_BumpTex, i.uv));
				float diff = max(0, dot(N, i.lightDir));
				float atten = length(_WorldSpaceLightPos0 - i.posW);
				atten = 1 / (1 + atten * atten);
				c = c * (diff * atten);
				return c;
			}
			ENDCG
		}
	}
}
