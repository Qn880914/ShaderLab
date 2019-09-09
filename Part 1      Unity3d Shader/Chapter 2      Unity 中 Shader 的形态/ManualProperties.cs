using UnityEngine;

public class ManualProperties : MonoBehaviour
{
    [SerializeField] private Renderer m_Renderer;

    private int m_ColorID;

    // Start is called before the first frame update
    void Start()
    {
        m_ColorID = Shader.PropertyToID("_Color");
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.R))
            m_Renderer.sharedMaterial.SetColor(m_ColorID, Color.red);
        else if (Input.GetKeyDown(KeyCode.G))
            m_Renderer.sharedMaterial.SetColor(m_ColorID, Color.green);
        else if (Input.GetKeyDown(KeyCode.B))
            m_Renderer.sharedMaterial.SetColor(m_ColorID, Color.blue);

        if(Input.GetKeyDown(KeyCode.P))
        {
            Color color = m_Renderer.sharedMaterial.GetColor(m_ColorID);
            Debug.Log(color);
        }
    }
}
