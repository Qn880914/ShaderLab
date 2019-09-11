using UnityEngine;

public class LOD : MonoBehaviour
{
    [SerializeField] private int m_MaximumLOD = 100;

    [SerializeField] private int m_GlobalMaximumLOD = 200;

    [SerializeField] private Material m_Material;


    // Start is called before the first frame update
    void Start()
    {
        m_Material.shader.maximumLOD = -1;
    }

    // Update is called once per frame
    void Update()
    {
        //m_Material.shader.maximumLOD = m_MaximumLOD;
        Shader.globalMaximumLOD = m_GlobalMaximumLOD;
    }
}
