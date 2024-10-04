import { Hono } from 'hono';

const app = new Hono<{ Bindings: CloudflareBindings }>()


// Serve static files
app.get('/log', async (c) => {
  const url = new URL(c.req.url, 'http://localhost')
  const path = url.pathname.replace(/^\//, '')
  const filePath = path.startsWith('public/') ? path.slice(7) : path
  console.log("loaded context", JSON.stringify(c))
  
  try {
    const fileContent = await c.env.ASSETS.fetch(filePath)
    return c.text(fileContent.toString())
  } catch (error) {
    return c.text('400 Problemo', { status: 400 })
  }
})


app.get('/', (c) => {
  return c.text('Hello Hono!')
})


export default app