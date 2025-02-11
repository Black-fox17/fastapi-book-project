from fastapi import APIRouter, HTTPException

from api.routes import books
from .db import Book, db

api_router = APIRouter()
api_router.include_router(books.router, prefix="/books", tags=["books"])

# Initialize some sample books
sample_books = [
    Book(id=1, title="The Hobbit", author="J.R.R. Tolkien", 
         publication_year=1937, genre="Fantasy"),  
]
for book in sample_books:
    db.add_book(book)


@api_router.get("/books/{book_id}")
async def get_book(book_id: int):
    book = db.get_book(book_id)
    print(book)
    if not book:
        raise HTTPException(status_code=404, detail="Book not found")
    return book

@api_router.delete("/books/{book_id}", status_code=204)
async def delete_book(book_id: int):
    deleted = db.delete_book(book_id)  # ✅ Use return value
    if not deleted:
        raise HTTPException(status_code=404, detail="Book not found")