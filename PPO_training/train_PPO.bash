base_model_name="gpt2-medium"
base_model_folder=""
PM_model_name="gpt2-medium"
accelerate launch --config_file accelerate.yaml PPO_training/PPO_training.py \
    --train.epochs 10000 \
    --train.batch_size 4 \
    --train.minibatch_size 1 \
    --train.seq_length 512 \
    --train.checkpoint_interval 20000 \
    --train.total_steps 10000 \
    --train.eval_interval 10000 \
    --model.model_path "${base_model_folder}${base_model_name}" \
    --tokenizer.tokenizer_path "${base_model_folder}${base_model_name}" \
    --PM_path "data/PM_LoRAs/${PM_model_name}" \
    --training_set_path "data/datasets/hh-rlhf-train-extracted.jsonl" \
    --test_set_path "data/datasets/hh-rlhf-test-extracted.jsonl" \
    --train.checkpoint_dir "data/trained_models/${base_model_name}_5" \
    --reward_batch_size 2 \
    --MORL True \
    --PMs "ethicality,factuality,helpfulness,sycophancy,toxicity,bias,conciseness,context,detail,empathy,relevance,understandability" \
    --scalarizer "linear" \
    --weight_file "data/weights/linear_14.json" 