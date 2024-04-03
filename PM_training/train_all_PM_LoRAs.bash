pm_dir="principles"
model_folder="microsoft/"
model_name="phi-2"
# Loop over every principle
for file in "$pm_dir"/*.txt; do
    # Extract the filename without the path and extension
    principle=$(basename -- "$file" .txt)
    echo "Training $principle PM"
    accelerate launch --config_file accelerate.yaml PM_training/train_PM.py \
        --principle="$principle" \
        --model_name="${model_folder}${model_name}" \
        --dataset_dir="" \
        --output_dir="data/PMs/${model_name}_${principle}" \
        --per_device_train_batch_size=1 \
        --num_train_epochs=1 \
        --gradient_accumulation_steps=1 \
        --gradient_checkpointing=False \
        --learning_rate=5e-5 \
        --report_to="wandb" \
        --remove_unused_columns=False \
        --optim="adamw_torch" \
        --logging_steps=1 \
        --eval_steps=0.1 \
        --evaluation_strategy="steps" \
        --max_length=512 \
        --num_proc=4 \
        --save_steps=0.2 \
        --LoRA=True \
        --LoRA_r=8 \
        --LoRA_alpha=32 \
        --LoRA_dropout=0.1 \
        --warmup_steps=250 \
        --lr_scheduler_type="cosine" 
done