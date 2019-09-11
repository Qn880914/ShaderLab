using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SphereShadow : MonoBehaviour
{
    [SerializeField] private Transform m_CastingSphere;

    [SerializeField] private Renderer m_Receive;

    // Start is called before the first frame update
    void Start()
    {
        Vector3 position = m_CastingSphere.position;
        m_Receive.sharedMaterial.SetVector("_spPosition", new Vector4(position.x, position.y, position.z, 1.0f));
        m_Receive.sharedMaterial.SetFloat("_spRadius", m_CastingSphere.localScale.x / 2);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
