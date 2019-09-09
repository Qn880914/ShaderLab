Shader "Custom/LightModel_Lambert"
{
	Properties
	{
		_MainTex("Main Tex(RGB)", 2D) = "white" {}
	}

	SubShader
	{
		Pass
		{
			Tags{"LightMode" = "ForwardBase"}
			CGPROGRAM

#pragma target 3.0
#include "UnityCG.cginc"
#include "Lighting.cginc"

#pragma vertex vert
#pragma fragment frag

			struct vertexInput
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 position : SV_POSITION;
				float2 diff : TEXCOORD0;
			};

			v2f vert(vertexInput i)
			{
				v2f o;
				o.position = UnityObjectToClipPos(i.position);

				float3 worldNormal = UnityObjectToWorldNormal(i.normal);
				float diff = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
				o.diff = float2(diff, 0.0);
				return o;
			}

			float4 frag(v2f i) : COLOR
			{
				return float4(_LightColor0.rgb * i.diff.x, 1.0);
			}
			ENDCG
		}
	}

	FallBack "Diffuse"
}
