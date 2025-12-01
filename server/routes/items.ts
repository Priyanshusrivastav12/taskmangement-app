import { Router, Response } from 'express';
import { Item } from '../models';
import { authMiddleware, AuthRequest } from '../middleware/auth';
import { itemValidation, validateRequest } from '../middleware/validation';

const router = Router();

router.get('/', authMiddleware, async (req: AuthRequest, res: Response) => {
  try {
    const items = await Item.find({ user_id: req.userId })
      .sort({ created_at: -1 });

    res.json({ items });
  } catch (error) {
    console.error('Fetch items error:', error);
    res.status(500).json({ error: 'Failed to fetch items' });
  }
});

router.get('/:id', authMiddleware, async (req: AuthRequest, res: Response) => {
  try {
    const { id } = req.params;

    const item = await Item.findOne({ _id: id, user_id: req.userId });

    if (!item) {
      return res.status(404).json({ error: 'Item not found' });
    }

    res.json({ item });
  } catch (error) {
    console.error('Fetch item error:', error);
    res.status(500).json({ error: 'Failed to fetch item' });
  }
});

router.post('/', authMiddleware, itemValidation, validateRequest, async (req: AuthRequest, res: Response) => {
  try {
    const { title, description, status } = req.body;

    const newItem = new Item({
      user_id: req.userId,
      title,
      description: description || '',
      status: status || 'pending',
    });

    await newItem.save();

    res.status(201).json({ message: 'Item created successfully', item: newItem });
  } catch (error) {
    console.error('Create item error:', error);
    res.status(500).json({ error: 'Failed to create item' });
  }
});

router.put('/:id', authMiddleware, itemValidation, validateRequest, async (req: AuthRequest, res: Response) => {
  try {
    const { id } = req.params;
    const { title, description, status } = req.body;

    const updatedItem = await Item.findOneAndUpdate(
      { _id: id, user_id: req.userId },
      {
        title,
        description: description || '',
        status: status || 'pending',
      },
      { new: true, runValidators: true }
    );

    if (!updatedItem) {
      return res.status(404).json({ error: 'Item not found' });
    }

    res.json({ message: 'Item updated successfully', item: updatedItem });
  } catch (error) {
    console.error('Update item error:', error);
    res.status(500).json({ error: 'Failed to update item' });
  }
});

router.delete('/:id', authMiddleware, async (req: AuthRequest, res: Response) => {
  try {
    const { id } = req.params;

    const deletedItem = await Item.findOneAndDelete({ _id: id, user_id: req.userId });

    if (!deletedItem) {
      return res.status(404).json({ error: 'Item not found' });
    }

    res.json({ message: 'Item deleted successfully' });
  } catch (error) {
    console.error('Delete item error:', error);
    res.status(500).json({ error: 'Failed to delete item' });
  }
});

export default router;
