using UnityEngine;

public class RenderQueue : MonoBehaviour
{
    [SerializeField] private Material m_Material;

    [SerializeField] private int m_RenderQueue;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        m_Material.renderQueue = m_RenderQueue;
    }
}
