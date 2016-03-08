using UnityEngine;
using System.Collections;

public class Filter4bit : MonoBehaviour {

    [SerializeField]
    Shader shader;

    Material material;

    [SerializeField]
    [Range(1, 100)]
    float resolution = 1.0f;

    void Start()
    {
        material = new Material(shader);
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        material.SetFloat("_Resolution", resolution);
        Graphics.Blit(source, destination, material);
    }
}
