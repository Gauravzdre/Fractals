﻿Shader "Custom/BlackKnight/MandleBrot"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Area("Area", vector) = (0, 0, 16, 16)
		_MaxIter("MaxIteration", float) = 255
		_Color("Color", range(0,1)) = 0.5
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

			float4 _Area;
            sampler2D _MainTex;
			float _Color;
			float _MaxIter = 255;
			
            fixed4 frag (v2f i) : SV_Target
            {
				float2 c = _Area.xy + (i.uv - .5) * _Area.zw;
				float2 z;
				float iter;
				for (iter = 0; iter < _MaxIter; iter++) {
					z = float2(z.x*z.x - z.y*z.y, 2 * z.x*z.y) + c;
					if (length(z) > 2) break;
				}

                float m = sqrt(iter/_MaxIter);
				float4 col = sin(float4(0.23, 0.35, 0.6, 1) * m * 25) * 0.5;

				col += tex2D(_MainTex, float2(m, _Color));

				return col;
            }
            ENDCG
        }
    }
}
