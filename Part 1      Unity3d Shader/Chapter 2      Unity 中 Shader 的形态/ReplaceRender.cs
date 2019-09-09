using UnityEngine;

public class ReplaceRender : MonoBehaviour
{
    [SerializeField] private Camera m_Camera;

    [SerializeField] private Shader m_Shader;

    // Start is called before the first frame update
    void Start()
    {
        /*if (m_Camera != null && m_Shader != null)
            m_Camera.RenderWithShader(m_Shader, "RenderType");*/
            //m_Camera.SetReplacementShader(m_Shader, "RenderType");
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.R))
            m_Camera.ResetReplacementShader();
    }

    /*private void OnGUI()
    {
        / *if (m_Camera != null && m_Shader != null)
            m_Camera.RenderWithShader(m_Shader, "RenderType");* /
    }*/
}
