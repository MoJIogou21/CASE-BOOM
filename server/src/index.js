require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
app.use(cors());
app.use(express.json());
const pool = new Pool({ connectionString: process.env.DATABASE_URL });

app.get('/health', (_req, res) => res.json({ ok: true, service: 'case-boom-api' }));

app.get('/api/v1/cases', async (_req, res) => {
  try {
    const { rows } = await pool.query(
      'SELECT id, slug, title, price_coins FROM cases WHERE is_active = true ORDER BY sort_order'
    );
    res.json({ data: rows });
  } catch (e) {
    res.status(500).json({ error: 'database_error' });
  }
});

// Production TODO: authenticate user, lock wallet row, choose weighted item on server,
// debit balance and insert opening + inventory item in one DB transaction.
app.post('/api/v1/openings', async (req, res) => {
  const { caseId } = req.body || {};
  if (!caseId) return res.status(400).json({ error: 'caseId_required' });
  return res.status(501).json({ error: 'opening_not_configured', message: 'Server-side opening logic is not configured yet.' });
});

const port = Number(process.env.PORT || 3000);
app.listen(port, () => console.log(`CASE BOOM API listening on ${port}`));
