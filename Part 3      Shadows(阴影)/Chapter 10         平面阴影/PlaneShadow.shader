// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Custom/Shadow/PlaneShadow"
{
    Properties
    {
        _MainTex("Main Tex(RGB)", 2D) = "white" {}
        _3D("3D", 3D) = "white" {}
        _Cube("Cube", Cube) = "white" {}
        _2DArray("2D Array", 2DArray) = "white" {}
        
        _Float("Float", float) = 1
        _Int("Int", int) = 1
        _Range("Range", Range(0, 1)) = 0.5
        
        _Color("Color", Color) = (1.0, 0.0, 0.0, 1.0)
        _Vector("Vector", Vector) = (0.0, 0.0, 0.0, 0.0)
        
        _Intensity("Intensity", float) = 0.5
        
        [HideInInspector] _Hide("Hide", 2D) = "white" {}
        [NoScaleOffset] _Offset("Offset", 2D) = "white" {}
        [Normal] _Normal("Normal", 2D) = "white" {}
        [Gama]_Gama("Gama", 2D) = "white" {}
        [HDR]_HDR("HDR", 2D) = "white" {}
        [PreRenderData]_PreRenderData("Pre", 2D) = "white" {}
    }
    
    SubShader
    {
        Tags
        {
            "Queue" = "Geometry"
            "RenderType" = "Opaque"
            "ForceNoShadowCasting" = "False"
            "IgnoreProjector" = "False"
            "CanUseSpriteAtlas" = "True"
            "DisableBatching" = "False"
        }
        
        pass
        {
            //对 物体本身做一个简单的光照计算 
            Tags {"LightMode" = "ForwardBase"}
            Material{Diffuse(1, 1, 1, 1)}
            Lighting on
        } 
        
        Pass
        {
            Tags
            {
                "LightMode" = "ForwardBase"
            }
            
            Blend DstColor SrcColor
            Offset -1, -1
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            float4x4 _WorldToGround;
            float4x4 _GroundToWorld;
            float _Intensity;
            
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
                float atten : TEXCOORD0;
            };
            
            v2f vert(VertexInput i)
            {
                v2f o;
                //o.vertex = UnityObjectToClipPos(i.vertex);
                
                
                float3 lightDir = WorldSpaceLightDir(i.vertex);
                lightDir = mul((float3x3)(_WorldToGround), lightDir);
                lightDir = normalize(lightDir);
                
                float4 position = mul(unity_ObjectToWorld, i.vertex);
                position = mul(_WorldToGround, position);
                position.xz = position.xz - (position.y / lightDir.y) * lightDir.xz;
                position.y = 0;
                position = mul(_GroundToWorld, position);
                position = mul(unity_WorldToObject, position);
                o.vertex = UnityObjectToClipPos(position);
                o.atten = distance(position, i.vertex) / _Intensity;
                return o;
            }
            
            float4 frag(v2f i) : COLOR
            {
                return smoothstep(1, 0, i.atten / 2);//float4(0.3, 0.3, 0.3, 1.0);
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
                //o.vertex = UnityObjectToClipPos(i.vertex);
                
                
                float3 lightDir = WorldSpaceLightDir(i.vertex);
                lightDir = mul((float3x3)(_WorldToGround), lightDir);
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
                return float4(0.3, 0.3, 0.3, 1.0);
            }
            ENDCG
        }
    }
}
