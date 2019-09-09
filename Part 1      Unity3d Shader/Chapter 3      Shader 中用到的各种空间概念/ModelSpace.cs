using UnityEngine;

public class ModelSpace : MonoBehaviour
{
    [SerializeField] private Transform m_Transform;

    [SerializeField] private Camera m_Camera;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        // local Space
        if (Input.GetKeyDown(KeyCode.L))
            Debug.Log(m_Transform.worldToLocalMatrix.MultiplyPoint(Vector3.zero));

        if (Input.GetKeyDown(KeyCode.W))
            Debug.Log(m_Transform.localToWorldMatrix.MultiplyPoint(Vector3.zero));

        if (Input.GetKeyDown(KeyCode.C))
            Debug.Log(m_Camera.worldToCameraMatrix.MultiplyPoint(m_Transform.position));
    }
}
