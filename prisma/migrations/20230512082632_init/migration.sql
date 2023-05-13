-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "firstName" VARCHAR(255) NOT NULL,
    "lastName" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "password" VARCHAR(255) NOT NULL,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserRoles" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "UserRoles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_userRole" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "userRoleId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "user_userRole_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AppPermission" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "name" VARCHAR(255) NOT NULL,

    CONSTRAINT "AppPermission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "appPermission_userRole" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "userRoleId" INTEGER NOT NULL,
    "appPermissionId" INTEGER NOT NULL,

    CONSTRAINT "appPermission_userRole_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Students" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "birthdayAt" TIMESTAMPTZ NOT NULL,
    "emergencyPhone" VARCHAR(255) NOT NULL,
    "emergencyContactName" VARCHAR(255) NOT NULL,
    "age" INTEGER NOT NULL,

    CONSTRAINT "Students_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_student" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "userId" INTEGER NOT NULL,
    "studentId" INTEGER NOT NULL,

    CONSTRAINT "user_student_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Lessons" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "userId" INTEGER,

    CONSTRAINT "Lessons_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "lesson_student" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "startAt" TIMESTAMPTZ NOT NULL,
    "endAt" TIMESTAMPTZ NOT NULL,
    "studentId" INTEGER NOT NULL,
    "lessonId" INTEGER NOT NULL,

    CONSTRAINT "lesson_student_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StudentPayments" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "studentId" INTEGER NOT NULL,
    "amountEur" DOUBLE PRECISION NOT NULL,
    "paidAt" TIMESTAMPTZ NOT NULL,
    "payableType" VARCHAR(255) NOT NULL,
    "payableId" INTEGER NOT NULL,
    "note" VARCHAR(255),

    CONSTRAINT "StudentPayments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StudentAddresses" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ NOT NULL,
    "address1" VARCHAR(255) NOT NULL,
    "address2" VARCHAR(255),
    "zip" INTEGER NOT NULL,
    "city" VARCHAR(255) NOT NULL,
    "studentId" INTEGER NOT NULL,

    CONSTRAINT "StudentAddresses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_UserUserRole" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_AppPermissionUserRole" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_UserStudent" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "_lessonStudent" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "_UserUserRole_AB_unique" ON "_UserUserRole"("A", "B");

-- CreateIndex
CREATE INDEX "_UserUserRole_B_index" ON "_UserUserRole"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AppPermissionUserRole_AB_unique" ON "_AppPermissionUserRole"("A", "B");

-- CreateIndex
CREATE INDEX "_AppPermissionUserRole_B_index" ON "_AppPermissionUserRole"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_UserStudent_AB_unique" ON "_UserStudent"("A", "B");

-- CreateIndex
CREATE INDEX "_UserStudent_B_index" ON "_UserStudent"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_lessonStudent_AB_unique" ON "_lessonStudent"("A", "B");

-- CreateIndex
CREATE INDEX "_lessonStudent_B_index" ON "_lessonStudent"("B");

-- AddForeignKey
ALTER TABLE "user_userRole" ADD CONSTRAINT "user_userRole_userRoleId_fkey" FOREIGN KEY ("userRoleId") REFERENCES "UserRoles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_userRole" ADD CONSTRAINT "user_userRole_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appPermission_userRole" ADD CONSTRAINT "appPermission_userRole_userRoleId_fkey" FOREIGN KEY ("userRoleId") REFERENCES "UserRoles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appPermission_userRole" ADD CONSTRAINT "appPermission_userRole_appPermissionId_fkey" FOREIGN KEY ("appPermissionId") REFERENCES "AppPermission"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_student" ADD CONSTRAINT "user_student_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_student" ADD CONSTRAINT "user_student_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Lessons" ADD CONSTRAINT "Lessons_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lesson_student" ADD CONSTRAINT "lesson_student_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "lesson_student" ADD CONSTRAINT "lesson_student_lessonId_fkey" FOREIGN KEY ("lessonId") REFERENCES "Lessons"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentPayments" ADD CONSTRAINT "StudentPayments_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StudentAddresses" ADD CONSTRAINT "StudentAddresses_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "Students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserUserRole" ADD CONSTRAINT "_UserUserRole_A_fkey" FOREIGN KEY ("A") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserUserRole" ADD CONSTRAINT "_UserUserRole_B_fkey" FOREIGN KEY ("B") REFERENCES "UserRoles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AppPermissionUserRole" ADD CONSTRAINT "_AppPermissionUserRole_A_fkey" FOREIGN KEY ("A") REFERENCES "AppPermission"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AppPermissionUserRole" ADD CONSTRAINT "_AppPermissionUserRole_B_fkey" FOREIGN KEY ("B") REFERENCES "UserRoles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserStudent" ADD CONSTRAINT "_UserStudent_A_fkey" FOREIGN KEY ("A") REFERENCES "Students"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserStudent" ADD CONSTRAINT "_UserStudent_B_fkey" FOREIGN KEY ("B") REFERENCES "Users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_lessonStudent" ADD CONSTRAINT "_lessonStudent_A_fkey" FOREIGN KEY ("A") REFERENCES "Lessons"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_lessonStudent" ADD CONSTRAINT "_lessonStudent_B_fkey" FOREIGN KEY ("B") REFERENCES "Students"("id") ON DELETE CASCADE ON UPDATE CASCADE;
