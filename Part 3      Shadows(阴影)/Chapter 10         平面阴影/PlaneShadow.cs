using UnityEngine;

public class PlaneShadow : MonoBehaviour
{
    [SerializeField] private Transform m_Recive;

    [SerializeField] private Renderer m_ShadowCaster;

    private Matrix4x4 m_GroundToWorld;

    private Matrix4x4 m_WorldToGround;

    // Start is called before the first frame update
    void Start()
    {
        m_GroundToWorld = m_Recive.localToWorldMatrix;
        m_WorldToGround = m_Recive.worldToLocalMatrix;
        m_ShadowCaster.sharedMaterial.SetMatrix("_WorldToGround", m_WorldToGround);
        m_ShadowCaster.sharedMaterial.SetMatrix("_GroundToWorld", m_GroundToWorld);
    }

    // Update is called once per frame
    void Update()
    {
    }
}
