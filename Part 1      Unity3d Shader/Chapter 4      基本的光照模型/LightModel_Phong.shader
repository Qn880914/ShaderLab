Shader "Custom/LightModel_Phong"
{
    Properties
    {
        _MainTex("Main Tex(RGB)", 2D) = "white"{}
    }
    
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma target 3.0
            #include "Lighting.cginc"
            #include "UnityCG.cginc"
            
            #pragma vertex vert
            #pragma fragment frag
            
            struct vertexInput
            {
                float4 position : POSITION;
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
    }
    
    FallBack "Diffuse"
}
