# Retrieval Head

## Retrieval Head Detection
An algorithm that statistically calculate the retrieval score of attention heads in a transformer model.
Because FlashAttention can not return attention matrix, this algorithm is implemented by first caching with FlashAttention and apply normal attention for decoding. 
### Environment
**Core**: pytorch=2.0.1, transformers=4.37.2, flash-attn=2.5.6 (my environment)

**Other**: rouge_score, rouge-chinese, jieba

A Single 80G GPU is enough to detect up to 50K length.
### Usage :
```python
python3 retrieval_head_detection.py --model_path "microsoft/Phi-3.5-mini-instruct" --s 0 --e 30000 --language "en"
```
We also added support quantization but this does not work with flash_attn. Hence, this support is for non A100 GPUs.

```python
python3 retrieval_head_detection.py --model_path "microsoft/Phi-3.5-mini-instruct" --s 0 --e 30000 --language "en" --quantize 
```

Currently supporting: English(en), Chinese(zh), and German(de).

### To run translation-retreival head experiements
```python
python3 retrieval_head_multiling_detection.py --model_path "Qwen/Qwen2.5-3B-Instruct" --s 0 --e 30000 --language "en" --haystack_language "zh"
python3 retrieval_head_multiling_detection.py --model_path "Qwen/Qwen2.5-3B-Instruct" --s 0 --e 30000 --language "en" --haystack_language "de"
```

### To run masking experiements
```python
python3 needle_in_haystack_with_mask.py --model_path "Qwen/Qwen2.5-3B-Instruct" --s 0 --e 30000 --language "en" --mask_topk 8 --wandb
```

### Results:
All detection results are saved in "./head_score/*.json", where each head is saved in the format of 
```python
{layer-head_id: [list of retrieval scores across detections]}
```
**Directly load a results for Analysis**
```python
## load head score file, llama-2-7b-80k for example
import json
import numpy as np
with open('./head_score/llama-2-7b-80k.json') as file:
    head_list = json.loads(file.readline())
## use the average retrieval score and ranking
head_score_list = [([int(ll) for ll in l[0].split("-")],np.mean(l[1])) for l in head_list.items()]
head_score_list = sorted(head_score_list, key=lambda x: x[1], reverse=True) 
top_retrieval_heads = [[l[0],  round(np.mean(l[1]), 2)] for l in head_score_list][:10]
print(top_retrieval_heads)
'''
Head:[16, 19],   Retrieval Score: 0.94      Head:[11, 15],   Retrieval Score: 0.92      
Head:[8, 26],    Retrieval Score: 0.8       Head:[6, 9],     Retrieval Score: 0.62        
Head:[7, 12],    Retrieval Score: 0.61      Head:[17, 22],   Retrieval Score: 0.56
Head:[11, 2],    Retrieval Score: 0.46      Head:[6, 16],    Retrieval Score: 0.44
Head:[19, 15],   Retrieval Score: 0.42      Head:[21, 30],   Retrieval Score: 0.4
'''
``
Replace 'model_name' in './viz/CreateVizFromLLMTesting.ipynb' by the folder name of Needle-in-a-Haystack results.

**Mask top 30 Retrieval Head for Llama-2-7b-80K**:
![alt text](viz/top30.png)
**Mask random 30 non-Retrieval Head for Llama-2-7b-80K**:
![alt text](viz/random.png)
