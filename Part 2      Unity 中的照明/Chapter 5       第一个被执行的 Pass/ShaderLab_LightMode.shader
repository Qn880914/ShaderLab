
// LightMode 
// Unity 支持三种渲染路径 ： 
//          VertexLit、Forward、Deferred   Ligthing
// Pass 中的LightModel标签
//      VertexLit : 
//              Vertex
//      Forward :
//              ForwardBase
//              ForwardAdd
//      Deferred :
//              PrepassBase
//              PrepassFinal            
Shader "Custom/ShaderLab_LightMode"
{
    Properties
    {
        _MainTex("Main Tex(RGB)", 2D) = "white" {}
    }
    
    SubShader
    {
        Blend One One
        
        Pass 
        {
            Tags{"LightMode" = "ForwardBase"}
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            struct vertexInput
            {
                float4 color : COLOR;
                float4 position : POSITION;
                float3 normal : NORMAL;
                float3 tangent : TANGENT;
                float2 uv : TEXCOORD0;
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
                return float4(1.0, 0.0, 0.0, 1.0);
            }
            
            ENDCG
        }
        
        Pass
        {
            Tags{"LightMode" = "PrepassBase"}
            
            CGPROGRAM
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            
            struct vertexInput
            {
                float4 color : COLOR;
                float4 position : POSITION;
                float3 normal : NORMAL;
                float3 tangent : TANGENT;
                float2 uv : TEXCOORD0;
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
                return float4(0.0, 1.0, 0.0, 1.0);
            }
            
            ENDCG
        }
        
        // Deferred RenderPath
        Pass
        {
            Tags{"LightMode" = "PrepassAdd"}
            
            CGPROGRAM
            #pragma target 3.0
            #pragma vertex vert
            #pragma fragment frag
            
            struct vertexInput
            {
                float4 position : POSITION;
            };
            
            struct v2f
            {
                float4 position : POSITION;
            };
            
            v2f vert(vertexInput i)
            {
                v2f o;
                o.position = UnityObjectToClipPos(i.position);
                return o;
            }
            
            float4 frag(v2f i) : COLOR
            {
                return float4(0.0, 0.0, 1.0, 1.0);
            }
            ENDCG
        }
    }
}
