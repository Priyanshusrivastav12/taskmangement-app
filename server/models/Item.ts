import mongoose, { Document, Schema, Types } from 'mongoose';

export interface IItem extends Document {
  _id: Types.ObjectId;
  user_id: Types.ObjectId;
  title: string;
  description: string;
  status: 'pending' | 'completed' | 'in-progress';
  created_at: Date;
  updated_at: Date;
}

const itemSchema = new Schema<IItem>(
  {
    user_id: {
      type: Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    title: {
      type: String,
      required: true,
      trim: true,
    },
    description: {
      type: String,
      default: '',
      trim: true,
    },
    status: {
      type: String,
      enum: ['pending', 'completed', 'in-progress'],
      default: 'pending',
    },
  },
  {
    timestamps: {
      createdAt: 'created_at',
      updatedAt: 'updated_at',
    },
  }
);

// Create indexes for performance (similar to SQL indexes)
itemSchema.index({ user_id: 1 });
itemSchema.index({ status: 1 });
itemSchema.index({ created_at: -1 });

export const Item = mongoose.model<IItem>('Item', itemSchema);
