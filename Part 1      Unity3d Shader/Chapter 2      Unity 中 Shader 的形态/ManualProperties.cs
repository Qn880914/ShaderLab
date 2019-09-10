using UnityEngine;

public class ManualProperties : MonoBehaviour
{
    [SerializeField] private Renderer m_Renderer;

    private Material m_Material;

    private int m_ColorID;

    // Start is called before the first frame update
    void Start()
    {
        m_ColorID = Shader.PropertyToID("_Color");

        m_Material = m_Renderer.sharedMaterial;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.R))
            m_Material.SetColor(m_ColorID, Color.red);
        else if (Input.GetKeyDown(KeyCode.G))
            m_Material.SetColor(m_ColorID, Color.green);
        else if (Input.GetKeyDown(KeyCode.B))
            m_Material.SetColor(m_ColorID, Color.blue);

        if(Input.GetKeyDown(KeyCode.P))
        {
            Color color = m_Material.GetColor(m_ColorID);
            Debug.Log(color);
        }
    }
}
