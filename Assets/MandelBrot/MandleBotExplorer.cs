using UnityEngine;

public class MandleBotExplorer : MonoBehaviour {

    public Material m_Material;
    public Vector4 m_Area;
    [SerializeField] float moveSpeed;

    private void Awake() {
        m_Area = m_Material.GetVector("_Area");
    }

    private void Update() {
        if (Input.GetKey(KeyCode.KeypadPlus)) {
            m_Area.z += moveSpeed;
            m_Area.w += moveSpeed;
        }

        if (Input.GetKey(KeyCode.KeypadMinus)) {
            m_Area.z -= moveSpeed;
            m_Area.w -= moveSpeed;
        }

        if (Input.GetKey(KeyCode.W)) 
            m_Area.y -= moveSpeed;
        if (Input.GetKey(KeyCode.S))
            m_Area.y += moveSpeed;
        if (Input.GetKey(KeyCode.A)) 
            m_Area.x -= moveSpeed;
        if (Input.GetKey(KeyCode.D))
            m_Area.x += moveSpeed;
        Debug.Log(m_Area);

        m_Material.SetVector("_Area", m_Area);
    }
}
