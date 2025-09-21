export default async function handler(req, res) {
  if (req.method === "GET") {
    return res.status(200).json({ message: "OpenAI endpoint is alive. Use POST with a prompt." });
  }

  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed" });
  }

  try {
    let body = req.body;
    if (typeof body === "string") {
      body = JSON.parse(body);
    }

    const { prompt } = body;
    if (!prompt) {
      return res.status(400).json({ error: "Missing prompt" });
    }

    const response = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${process.env.OPENAI_API_KEY}`,
      },
      body: JSON.stringify({
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a helpful biology assistant." },
          { role: "user", content: prompt }
        ],
        max_tokens: 1000,
      }),
    });

    const data = await response.json();
    const result = data.choices?.[0]?.message?.content || "No response generated.";
    res.status(200).json({ result });

  } catch (error) {
    console.error("Handler Error:", error);
    res.status(500).json({ error: error.message });
  }
}

export default function handler(req, res) {
  if (req.method === "GET") {
    return res.status(200).json({ ok: true });
  }
  res.setHeader("Allow", ["GET"]);
  res.status(405).end(`Method ${req.method} Not Allowed`);
}
