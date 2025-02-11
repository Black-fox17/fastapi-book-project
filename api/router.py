from fastapi import APIRouter, HTTPException

from api.routes import books
from .db import Book, InMemoryDB

api_router = APIRouter()
api_router.include_router(books.router, prefix="/books", tags=["books"])

db = InMemoryDB()

# Initialize some sample books
sample_books = [
    Book(id=1, title="The Great Gatsby", author="F. Scott Fitzgerald", 
         publication_year=1925, genre="Mystery"),
    Book(id=2, title="Dune", author="Frank Herbert", 
         publication_year=1965, genre="Science Fiction"),
    Book(id=3, title="The Hobbit", author="J.R.R. Tolkien", 
         publication_year=1937, genre="Fantasy")
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