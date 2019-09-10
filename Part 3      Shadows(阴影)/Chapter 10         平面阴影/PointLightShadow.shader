Shader "Custom/Shadow/PointLightShadow"
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
            Tags{"LightMode" = "ForwardBase"}
            
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
        
        Pass
        {
            Tags{"LightMode" = "ForwardAdd"}
            
            Blend DstColor SrcColor
            
            Offset -1, -1
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            float4x4 _WorldToGround;
            float4x4 _GroundToWorld;
            
            struct VertexInput
            {
                float4 vertex : POSITION;
            };
            
            struct v2f
            {
                float4 vertex : SV_POSITION;
            };
            
            v2f vert(VertexInput i)
            {
                v2f o;
                
                float3 lightDir = WorldSpaceLightDir(i.vertex);
                lightDir = mul((float3x3)_WorldToGround, lightDir);
                lightDir = normalize(lightDir);
                float4 position = mul(unity_ObjectToWorld, i.vertex);
                position = mul(_WorldToGround, position);
                position.xz = position.xz - (position.y / lightDir.y) * lightDir.xz;
                position.y = 0;
                position = mul(_GroundToWorld, position);
                position = mul(unity_WorldToObject, position);
                o.vertex = UnityObjectToClipPos(position);
                
                return o;
            }
            
            float4 frag(v2f i) : COLOR
            {
                return float4(0.0, 1.0, 0.0, 1.0);
            }
            ENDCG
        }
    }
}
